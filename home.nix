{ config, pkgs, ... }:
{
    /* Here goes your home-manager config, eg home.packages = [ pkgs.foo ]; */
    programs.git = {
    	enable = true;
    	userName  = "Ali Neishabouri";
    	userEmail = "ali.neishabouri@theactigraph.com";
  	};

}

