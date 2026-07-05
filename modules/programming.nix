{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
	helix

	rustup
	rust-analyzer  

	clang

	gcc
  ];
}
