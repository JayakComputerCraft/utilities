DataFile = {}

File = File or require 'jayak.utilities.File'
String = String or require 'jayak.utilities.String'

function DataFile:new(path, autoSave)
    instance = {
        _ = {
            autoSave = autoSave or false,
            data = {},
            file = File:new(path),
        },
    }

    setmetatable(instance, self)
    self.__index = function (table, key)
        return table._.file[key] or table._.data[key]
    end
    self.__newindex = function (table, key, value)
        rawset(table._.data, key, value)

        if table._.autoSave then instance:save() end
    end

    instance:load()

    return instance
end

function DataFile:load()
    self._.data = String.unserialize(self:get())

    return self
end

function DataFile:save()
    self:put(String.serialize(self._.data))
end

return DataFile