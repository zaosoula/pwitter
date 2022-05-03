json.array!(@follows) do |follow|
  json.extract! follow, :created_at, :source
end
