# Homebrew formula for Docka
# To install: brew install docka-dev/tap/docka

class Docka < Formula
  desc "Self-hosted cloud infrastructure management platform"
  homepage "https://docka.dev"
  version "0.4.7"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/docka-dev/docka-releases/releases/download/v#{version}/docka-darwin-arm64.tar.gz"
      sha256 "b24f90938b7e2d387e05f5192300588f9bb966a2721170b3b6de5a5680da3aa9"
    end
    on_intel do
      url "https://github.com/docka-dev/docka-releases/releases/download/v#{version}/docka-darwin-amd64.tar.gz"
      sha256 "50850fc5aab5824af570372e2e6154ceae0eaab99ff3f199774e518f640b4315"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/docka-dev/docka-releases/releases/download/v#{version}/docka-linux-arm64.tar.gz"
      sha256 "9c3a42979788f44d6a5846acd9265f3e9510379eacedb4eca242a9f565e87bba"
    end
    on_intel do
      url "https://github.com/docka-dev/docka-releases/releases/download/v#{version}/docka-linux-amd64.tar.gz"
      sha256 "1adece15c1059f8822a04f40a9547e2bfe99741884daef51047da8c1931ff0aa"
    end
  end

  def install
    bin.install "docka"
    bin.install "docka-server"
    bin.install "docka-agent" if OS.linux?
  end

  def caveats
    <<~EOS
      Docka has been installed!

      Quick start:
        docka-server          # Start the Docka server
        docka --help          # CLI commands

      Documentation: https://docka.dev/docs
    EOS
  end

  service do
    run [opt_bin/"docka-server"]
    keep_alive true
    working_dir var/"docka"
    log_path var/"log/docka.log"
    error_log_path var/"log/docka.error.log"
  end

  test do
    assert_match "docka version", shell_output("#{bin}/docka --version")
  end
end
