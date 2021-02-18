
-- data type
-- nil, boolean, number, string, function, userdata, thread, table


-- table key-value
local table = {}

-- 同时指定 key value 来初始化 table
local complex1 = {real = 42.0, a1 = 0.0}
local complex2 = {}
complex2["real"] = 42.0
complex2.image = 42.0

--

-- 初始化时只指定一种值，默认为数组，key 默认从 1开始递增
-- 对 key 为 1 的位置进行改动
local table_array = {"aa", "adad", "dscce", "dsffawsd"}
table_array[1] = "bb"



--[[
    table key-value
    key 可以是除去 nil 的任何类型
    value 可以是任何类型
--]]


local table_c = {} -- default initialization
table_c["A"] = "a"
table_c["B"] = "b"
table_c["C"] = "c"
table_c.D = 4
table_c["D"] = nil

table_c = nil -- destroy table


local table_b = {name = "JCC", age = "22", sex = "male"} -- initialization with params
print(table_b["name"])
table_b["name"] = "jcc"
print(table_b["name"])

table_b = nil -- destroy table

--[[
    loops

--]]
local table_a = {name = "snx", age = "22", sex = "female"}

-- while
while(true) do
    print(table_a["name"])
end

-- 数值循环
-- for var = exp1, exp2, exp3(optional) do
-- exp1 起始值 exp2 末尾值 exp3 增长值（不写默认1）
for i=1, 3, 3 do
   print(table_a["name"])
end

for i=1, 3 do
    print(table_a["name"])
end

-- 泛型循环
for key, value in pairs(table_a) do
    print(key, value)
end

-- repeat..until
repeat
    print(table_a["name"])
until(true)

-- break goto （循环）控制
-- break 跳出当前循环，并结束所有循环
-- goto 将程序控制点转移到指定标签

for key, value in pairs(table_a) do
    if key == "name" then goto continue end
    print(key, value)
    -- statements
    ::continue::
end



--[[
    iterators

--]]


for key, value in pairs(table_a) do
    print(key, value)
end



-- construct a module and then return it
module1 = {}

module1.version = 3.0
module1.time = "2020.8.9"

function test1()
    print("aaadasdwad")
end

local function test2()
    print("sdsdwwwsds")
end

module1.func1 = test1
module1.func2 = test2


return module1
-- over

local m1 = require("module1")
m1.func1()
m1.func2()




