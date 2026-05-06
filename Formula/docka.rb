# Homebrew formula for Docka
# To install: brew install docka-dev/tap/docka

class Docka < Formula
  desc "Self-hosted cloud infrastructure management platform"
  homepage "https://docka.dev"
  version "0.4.13"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/docka-dev/docka-releases/releases/download/v#{version}/docka-darwin-arm64.tar.gz"
      sha256 "5d15b181809febbc3253934015e5e962dec44d5ab03ccf2a669b373f20ed38fb"
    end
    on_intel do
      url "https://github.com/docka-dev/docka-releases/releases/download/v#{version}/docka-darwin-amd64.tar.gz"
      sha256 "c17bf3dd96154b89e4ecbd8d8f6cc358653303300188f2a993b7f08823d40ffe"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/docka-dev/docka-releases/releases/download/v#{version}/docka-linux-arm64.tar.gz"
      sha256 "bfd502f7569836a1f99724c0cb091d15586b629e8855cd3a8f513f2e98689552"
    end
    on_intel do
      url "https://github.com/docka-dev/docka-releases/releases/download/v#{version}/docka-linux-amd64.tar.gz"
      sha256 "6333f2fdf868352a485f2f915378d30c7acb2e5d55eb64a03876aa01068ccd45"
    end
  end

  def install
    binary_name = if OS.mac?
      Hardware::CPU.arm? ? "docka-darwin-arm64" : "docka-darwin-amd64"
    else
      Hardware::CPU.arm? ? "docka-linux-arm64" : "docka-linux-amd64"
    end

    bin.install binary_name => "docka"
    bin.install binary_name => "docka-server"
  end

  def caveats
    <<~EOS
      Docka has been installed!

      Quick start:
        docka-server          # Start the Docka server
        docka --version       # Inspect installed version

      Documentation: https://docka.dev/docs
      Note: The Docka agent is distributed as a separate Linux-only release artifact.
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
    assert_match version.to_s, shell_output("#{bin}/docka-server --version")
  end
end
