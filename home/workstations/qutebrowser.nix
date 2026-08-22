{
  # Fix "unsupported browser" google login issues
  # :set -u https://accounts.google.com/* content.headers.user_agent "Mozilla/5.0 ({os_info}; rv:135.0) Gecko/20100101 Firefox/135"
  programs.qutebrowser = {
    enable = true;
    perDomainSettings."https://accounts.google.com/*".content.headers.user_agent =
      "Mozilla/5.0 ({os_info}; rv:135.0) Gecko/20100101 Firefox/135";
    settings.content.blocking.method = "adblock";
  };
}
