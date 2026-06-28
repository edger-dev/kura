{
  description = "Kura — personal media archive built on Kinora and Moco";

  inputs.jig.url = "github:edger-dev/jig";

  outputs = { self, jig }:
    jig.lib.mkWorkspace
      {
        pname = "kura";
        src = ./.;
      }
      {
        rust = { };
      };
}
