{
  nix.settings = {
    substituters = [
      "https://roar.cachix.org"
      "https://ros.cachix.org"
    ];
    trusted-public-keys = [
      "roar.cachix.org-1:XYRwk2AeKATRiicsHxRkk3VWIaitbG6saW5YZvIaPec="
      "ros.cachix.org-1:dSyZxI8geDCJrwgvCOHDoAfOm5sV1wCPjBkKL+38Rvo="
    ];
  };

  # Allow ROS2 ports from DOMAIN_ID 42 to 51 with 150 participants
  networking.firewall.allowedUDPPortRanges = [
    {
      from = 17900;
      to = 20461;
    }
  ];
}
