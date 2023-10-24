# Use busybox for i686-linux since it works on x86_64-linux as well.
(import ./i686-unknown-linux-gnu.nix) //

{
  bootstrapTools = import <nix/fetchurl.nix> {
    url = "https://f000.backblazeb2.com/file/nix-artifacts/bootstrap-tools.tar.xz";
    sha256 = "6c5ce923ed558af69dbde93f34d8674e1ac96e63d8e05f29231c7bdf9fa4122d";
  };
}
