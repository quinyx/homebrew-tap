# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class FrontendDevRelay < Formula
  desc "Powerup Frontend workflow, no more waiting for Backend to deliver"
  homepage "https://quinyx.com/"
  version "2.60.14"
  bottle :unneeded

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/quinyx/homebrew-tap/releases/download/v2.60.14/frontend-dev-relay_2.60.14_darwin_amd64.tar.gz"
      sha256 "f5cf6df8ee8fac237911800f8da3945a352b8da6b1656e6e96e6fa141d25c476"
    end
    if Hardware::CPU.arm?
      url "https://github.com/quinyx/homebrew-tap/releases/download/v2.60.14/frontend-dev-relay_2.60.14_darwin_arm64.tar.gz"
      sha256 "f50099f16870cd47b48c62d9dd81fd8c2d174b5506e7c88bc95a808880dfc3cf"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/quinyx/homebrew-tap/releases/download/v2.60.14/frontend-dev-relay_2.60.14_linux_amd64.tar.gz"
      sha256 "6d7a82b159cd1eeee455cc2660a6e5d7faa0f7350d347f6003f1f88782c1d3f3"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/quinyx/homebrew-tap/releases/download/v2.60.14/frontend-dev-relay_2.60.14_linux_arm64.tar.gz"
      sha256 "73cc55bf765e48eac0a8cea4e66b940a98119a3f73c7d598eb65d1cad3a78a77"
    end
  end

  def install
    bin.install "frontend-dev-relay"
  end
end
