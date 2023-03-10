

require "pbin"
isLogActive = false
httpPut = false
FOLDER = "logs"
FILE_NAME = "log"
FILE_PATH = FOLDER .. "/" .. FILE_NAME
PriorityLevels = {
    INFO = "info",
    DEBUG = "debug",
    ERROR= "error"
}

function debug(active,pastenbinPut)
    isLogActive = active
    httpPut = isLogActive and pastenbinPut
end


local function writeLines(lines)

    if not fs.exists(FOLDER) then
        fs.makeDir(FOLDER)
    end

    local filepath = FILE_PATH .. os.date('%Y-%m-%d-%H:%M:%S') .. ".txt" 
    local file = fs.open(filepath, "w")
    for k,v in ipairs(lines) do
        print("GOONNNANNN")
        print(v)
        file.writeLine(v)
    end
    file.close()
    return filepath
end
local function pastenbinPut(filepath)
   local pastebinUrl = put(filepath)
   writeLines({pastebinUrl})
end

function logger(input,level,source)
    local lines = {}
    if isLogActive then
        if not source then
            source = "DEBUG"
        end
        local line = "["..source:upper().."] " .. input
        lines[#lines + 1] = line
        print(line)
    end
    local filename = writeLines(lines)
    if httpPut then
        pastenbinPut(filename)
    end
end







