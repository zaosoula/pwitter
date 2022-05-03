json.array!(@follows) do |follow|
  json.extract! follow, :created_at, :target
end

