$SCOOP_PROGRAMMING_LANGUAGES = @(
  "java/oraclejre8",
  "main/gdb",
  "main/llvm",
  "main/mingw",
  "main/nodejs",
  "main/python",
  "main/rust"
  # "main/lua",
  #"main/docker",
  #"main/docker-compose",
)

scoop install $SCOOP_PROGRAMMING_LANGUAGES
