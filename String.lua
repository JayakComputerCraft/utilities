String = {}

function String.serialize(value)
    return textutils.serialize(value)
end

function String.unserialize(value)
    return textutils.unserialize(value)
end

return String