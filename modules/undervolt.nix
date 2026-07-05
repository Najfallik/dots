{ pkgs, ... }:
{
	environment.systemPackages = with pkgs; [
		intel-undervolt
		stress-ng
	];
}
