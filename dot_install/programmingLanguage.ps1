$SCOOP_PROGRAMMING_LANGUAGES = @(
  "java/oraclejre8",
  "main/docker",
  "main/docker-compose",
  "main/gdb",
  "main/llvm",
  "main/mingw",
  "main/nodejs",
  "main/python",
  "main/rust"
  # "main/lua",
)

scoop install $SCOOP_PROGRAMMING_LANGUAGES
