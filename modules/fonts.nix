{ pkgs, ... }:
{
	fonts.packages = with pkgs; [
		fira-sans
    	fira-code
    	fira-code-symbols
	];
}
