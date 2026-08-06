{
  nixpkgs.config.rocmSupport = true;
  hardware.amdgpu = {
    initrd.enable = true;
    opencl.enable = true;
    zluda.enable = true;
  };
}
