function success = checkVlfeatIsInstalled()

try
    vl_version
catch
    success = false;
    return
end

success = true;

end