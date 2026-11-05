{ userName, ... }:
{
  sops.defaultSopsFile = "/home/${userName}/nix-config/secrets/servers.yaml";
  sops.age.keyFile = "/home/${userName}/.config/sops/age/key.txt";
  sops.age.sshKeyPaths = [ "/home/${userName}/.ssh/id_ed25519" ];
  sops.validateSopsFiles = false;
}
