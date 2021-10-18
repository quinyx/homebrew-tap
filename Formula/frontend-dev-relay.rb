# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class FrontendDevRelay < Formula
  desc "Powerup Frontend workflow, no more waiting for Backend to deliver"
  homepage "https://quinyx.com/"
  version "2.57.22"
  bottle :unneeded

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/quinyx/homebrew-tap/releases/download/v2.57.22/frontend-dev-relay_2.57.22_darwin_arm64.tar.gz"
      sha256 "e79017cd5ffbacea057d9bc57749724d1bfda186fb02fc159c97f76ac153363f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/quinyx/homebrew-tap/releases/download/v2.57.22/frontend-dev-relay_2.57.22_darwin_amd64.tar.gz"
      sha256 "380bd3a784ff6793d7dd216611c53fa7535744398d7a298df42609fb7d20194d"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/quinyx/homebrew-tap/releases/download/v2.57.22/frontend-dev-relay_2.57.22_linux_amd64.tar.gz"
      sha256 "a51aabad69597b91d9d79c916f1dd1004edbeb1b96d52b49d47d6eedb8dd6925"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/quinyx/homebrew-tap/releases/download/v2.57.22/frontend-dev-relay_2.57.22_linux_arm64.tar.gz"
      sha256 "d55bb6a5963993953931ca85380091b041eb4d84da274eb81af4fcdef26ce386"
    end
  end

  def install
    bin.install "frontend-dev-relay"
  end
end
