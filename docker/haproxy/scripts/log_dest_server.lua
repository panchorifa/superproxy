-- Log where requests are sent from and to

-- mp = Map.new("maps/ip_svc.map", Map.str)

function log_req(txn)
  ip_from = txn.f:src()
  txn.Info(txn, 'Source: ' .. txn.f:src())
  if ip_from == nil then
     return 'N/A'
  end

  local svc_from = 'apixxx'
  if svc_from == nil then
     return 'N/A'
  end
  txn.set_var(txn, 'from_svc', svc_from)
  txn.Info(txn, 'From: ' .. svc_from)
  return svc_from
end

core.register_fetches("log_req", log_req)

function log_res(txn)
  local from_svc = txn.get_var(txn, 'txn.from_svc')
  local to_svc = txn.get_var(txn, 'req.backend_name')
  local date = txn.sc:http_date(txn.f:date())
  local log_text = date .. " Request from: " .. from_svc .. " Request to: " .. to_svc .. "\n"
  txn.Info(txn, log_text)

  local log_file = io.open("/var/log/demo.log", "a")
  log_file:write(log_text)
  log_file:close()
end

core.register_action("log_res", {"tcp-req","http-req"}, log_res)
