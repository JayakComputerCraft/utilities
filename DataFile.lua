DataFile = {}

File = File or require 'jayak.utilities.File'
String = String or require 'jayak.utilities.String'

function DataFile:new(path, autoSave)
    instance = {
        _ = {
            autoSave = autoSave or false
        },
        data = {},
        file = File:new(path),
    }

    setmetatable(instance, self)
    self.__index = function(table, key)
        return DataFile[key] or table.data[key]
    end
    self.__newindex = function(table, key, value)
        rawset(table.data, key, value)

        if table._.autoSave then
            instance:save()
        end
    end

    if instance.file:exists() == false then
        instance:save()
    end

    instance:load()

    return instance
end

function DataFile:load()
    self.data = String.unserialize(self.file:get())

    return self
end

function DataFile:save()
    self.file:put(String.serialize(self.data))
end

return DataFile