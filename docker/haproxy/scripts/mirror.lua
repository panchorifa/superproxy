-- a simple mirror web server
-- it generates a response whose body contains the requests headers
function mirror(txn)
  local buffer = ""
  local response = ""
  local mydate = txn.sc:http_date(txn.f:date())

  buffer = buffer .. "You sent the following headersrn"
  buffer = buffer .. "===============================================rn"
  buffer = buffer .. txn.req:dup()
  buffer = buffer .. "===============================================rn"

  response = response .. "HTTP/1.0 200 OKrn"
  response = response .. "Server: haproxy-lua/mirrorrn"
  response = response .. "Content-Type: text/htmlrn"
  response = response .. "Date: " .. mydate .. "rn"
  response = response .. "Content-Length: " .. buffer:len() .. "rn"
  response = response .. "Connection: closern"
  response = response .. "rn"
  response = response .. buffer

  txn.res:send(response)
  txn:close()
end
