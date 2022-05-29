netsh interface portproxy show all
netsh interface portproxy add v4tov4 listenport=9030 connectport=9030 connectaddress=123.56.159.54
netsh interface portproxy delete v4tov4 listenport=9030
netsh interface portproxy reset