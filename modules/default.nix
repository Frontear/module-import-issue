{ impermanence, ... }: ({ lib, ... }: {
  imports = lib.forEach (lib.filter (p: p != ./default.nix && lib.hasSuffix "default.nix" p) (lib.filesystem.listFilesRecursive ./.)) (f: (import f { inherit impermanence; }));
})
