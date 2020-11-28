File = {
    READ = 'r',
    WRITE = 'w'
}

function File:new(path)
    instance = { path = path }

    setmetatable(instance, self)
    self.__index = self

    return instance
end

function File:exists()
    return fs.exists(self.path)
end

function File:get()
    local handle = fs.open(self.path, self.READ)
    content = handle.readAll()
    handle.close()

    return content
end

function File:put(content)
    local handle = fs.open(self.path, self.WRITE)
    handle.write(content)
    handle.close()

    return self
end

return File