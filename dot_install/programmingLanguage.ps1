$CHOCO_PROGRAMMING_LANGUAGES = @(
  "llvm",
  "mingw",
  "gnuwin32-coreutils.install",
  "nodejs",
  "python",
  "javaruntime",
  "rust",
  "docker-desktop"
)

choco install $CHOCO_PROGRAMMING_LANGUAGES -y
