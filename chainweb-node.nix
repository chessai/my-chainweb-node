{
  services.chainweb-node = {
    enable = true;

    # Run a replay and exit
    onlySyncPact = true;
    validateHashesOnReplay = true;

    # Log errors only
    logLevel = "error";
  };
}
