--MIT License
--
--Copyright (c) 2023 ttwiz_z
--
--Permission is hereby granted, free of charge, to any person obtaining a copy
--of this software and associated documentation files (the "Software"), to deal
--in the Software without restriction, including without limitation the rights
--to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
--copies of the Software, and to permit persons to whom the Software is
--furnished to do so, subject to the following conditions:
--
--The above copyright notice and this permission notice shall be included in all
--copies or substantial portions of the Software.
--
--THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
--IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
--FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
--AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
--LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
--OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
--SOFTWARE.

local ArgumentParser = require("argparse")
local JSON = require("json")

local Parser = ArgumentParser("HitoParser", ".ROBLOSECURITY Parser")
Parser:argument("harPath", "The path to the .har file")
local Arguments = Parser:parse()

local function FileExists(File)
    File = io.open(File, "rb")
    if File then
        File:close()
    end
    return File ~= nil
end

if not FileExists(Arguments.harPath) then
    print("The .har file not found")
    return
else
    if string.sub(Arguments.harPath, -4) ~= ".har" then
        print("The file format must be .har")
        return
    end
end

local Lines = {}
for Line in io.lines(Arguments.harPath) do
    Lines[#Lines + 1] = Line
end

local Data = JSON.decode(table.concat(Lines, "\n"))

for Index, Value in next, Data.log.entries[1].request.cookies do
    if Value.name == "\46\82\79\66\76\79\83\69\67\85\82\73\84\89" then
        print(Value.value)
        break
    end
end