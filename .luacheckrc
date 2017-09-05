std = "min"
cache = true
exclude_files = {".luacheckrc"}

files["spec/*.spec.lua"].std = "+busted"
files["spec/samples/*/*.lua"].read_globals = {"obey"}
files["obey-*.rockspec"].std = "rockspec"
