var express = require('express');
var app = express();
var http = require('http').Server(app);
var io = require('socket.io')(http)
var Convert = require('ansi-to-html');
var convert = new Convert();
var spawn = require('child_process').spawn

function htmlEntities(str) {
  return String(str)
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;');
}

//TODO this should be local
var p = spawn('bash');

app.set('view engine', 'ejs');
app.set('views', '.');

app.get('/', function(req, res) {
  res.render('./public/index');
});

app.use(express.static('public'));

io.on('connection', function(socket){
  console.log('< a user connected');

  socket.on('error', function(error) {
    console.error("socket error", error);
  });
  socket.on('disconnect', function(){
    console.log('< user disconnected');
  });

  function send(msg) {
    console.error(msg);
    try {
      socket.emit('bash-result', msg + '\n');
    } catch(e) {
      console.error('send error', e);
    }
  }

  // TODO only one command!
  socket.on('bash', function(command) {
    if (!command) {
      console.log("bash recieved an empty command, ignored");
      return;
    }

    const commands = [
      //"cd $(mktemp -d)"
      ]
      .concat(command.split("\n"))
      .concat([
        // "exit"
      ]);



    p.on('end',function (error) {
      console.log("bash ended!");
    });

    p.on('error',function (error) {
      console.error("error", error);
    });

    p.stdout.on('data',function (data) {
      const str = htmlEntities(data.toString());
      send(convert.toHtml(str));
    });

    const exit = setInterval(function() {
      if (!commands.length) {
        clearInterval(exit);
        return;
      }

      const cmd = commands[0].trim();
      commands.splice(0, 1);

      send(htmlEntities(`root> ${cmd}`));

      // ignore empty lines and comments
      if (cmd.length && cmd[0] != '#') {
        p.stdin.write(`${cmd}\n`);
      }
    }, 1000);


  });
});

http.listen(3000, function(){
  console.log('listening on *:3000');
});
