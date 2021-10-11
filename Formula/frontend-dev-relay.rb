# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class FrontendDevRelay < Formula
  desc "Powerup Frontend workflow, no more waiting for Backend to deliver"
  homepage "https://quinyx.com/"
  version "2.57.10"
  bottle :unneeded

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/quinyx/homebrew-tap/releases/download/v2.57.10/frontend-dev-relay_2.57.10_darwin_amd64.tar.gz"
      sha256 "fd646a7a081a249a43308fcf22a3832bad8c31c69e816a690ba28f73172098b7"
    end
    if Hardware::CPU.arm?
      url "https://github.com/quinyx/homebrew-tap/releases/download/v2.57.10/frontend-dev-relay_2.57.10_darwin_arm64.tar.gz"
      sha256 "31f4126ab9fa57b30bb5c79ddaf6f3c9035f5d7c1c3af047c1119a6e4159025d"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/quinyx/homebrew-tap/releases/download/v2.57.10/frontend-dev-relay_2.57.10_linux_amd64.tar.gz"
      sha256 "b5e5eb96e3b3c2ccdf1e4329fc6139425a00734b60aacb8bfa3c29b7f6459daa"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/quinyx/homebrew-tap/releases/download/v2.57.10/frontend-dev-relay_2.57.10_linux_arm64.tar.gz"
      sha256 "be832db8b0a26539e2fc6446b25570f3f117c9a5e3bcae4f21a57c20a2c86c97"
    end
  end

  def install
    bin.install "frontend-dev-relay"
  end
end
