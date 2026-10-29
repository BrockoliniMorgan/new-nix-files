{ specialArgs, ... }:
{
  home-manager = {
    backupFileExtension = "bkp";
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${specialArgs.userName} = ./.;
    extraSpecialArgs = specialArgs;
  };
}
