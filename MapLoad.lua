names ={ "Dungeon", "Fosso", "Siberia", "Mix", "Test", "Deserto","Lp" }

arrayMaps = {}
for i = 1, table.getn(names) do
    maps = Map:new("Labirinto - "..names[i] , require("/maps/"..names[i]) , i)
    table.insert( arrayMaps, maps )
end
return arrayMaps