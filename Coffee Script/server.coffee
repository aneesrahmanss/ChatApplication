io = require("socket.io").listen(8000)

# initialize socket connection
io.sockets.on "connection", (socket) ->
  
  # message from the sender.
  socket.on "chat", (data) ->
    
    # default value of the name of the sender.
    sender = "unregistered"
    
    # get the name of the sender
    socket.get "nickname", (err, name) ->
      console.log "Chat message by ", name
      console.log "error ", err
      sender = name

    
    # broadcast data recieved from the sender
    socket.broadcast.emit "chat",
      msg: data
      msgr: sender


  
  # then set the socket nickname to 
  socket.on "register", (name) ->
    
    # make a nickname paramater for this socket
    socket.set "nickname", name, ->
      io.sockets.emit "chat",
        msg: "Message from Server! Hi " + name + "!"
        msgr: "From Server"