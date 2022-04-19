# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Qlogtail < Formula
  desc "View Quinyx logs like a boss"
  homepage "https://quinyx.com/"
  version "60.21.0"
  bottle :unneeded

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/quinyx/homebrew-tap/releases/download/v60.21.0/qlogtail_60.21.0_darwin_arm64.tar.gz"
      sha256 "b2a0febfadc3d5520dde9745c8d34f282dd29036271aae729b285fb1ead2628d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/quinyx/homebrew-tap/releases/download/v60.21.0/qlogtail_60.21.0_darwin_amd64.tar.gz"
      sha256 "04c918e49784e12cc1dd8170052c4a63cce0a0e82799b2125f81bda856e14ce0"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/quinyx/homebrew-tap/releases/download/v60.21.0/qlogtail_60.21.0_linux_arm64.tar.gz"
      sha256 "4fa7197c5137c68ba6a150be24c512659d52ae9dcb43aec5b67886383ff5fabe"
    end
    if Hardware::CPU.intel?
      url "https://github.com/quinyx/homebrew-tap/releases/download/v60.21.0/qlogtail_60.21.0_linux_amd64.tar.gz"
      sha256 "5513b1bab4951317ac06da21c24e92a018d67905917f56bcf27fb536ceb939e3"
    end
  end

  def install
    bin.install "qlogtail"
  end
end
