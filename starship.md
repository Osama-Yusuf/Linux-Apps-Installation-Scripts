# To install Starship shell customization  

## Step 1. Install Starship
    curl -sS https://starship.rs/install.sh | sh

## Step 2. Setup your shell to use Starship
    for bash Add the following to the end of ~/.bashrc:
        eval "$(starship init bash)"
    for zsh Add the following to the end of ~/.zshrc:
        eval "$(starship init zsh)"

## Step 3. install proper font for better icons
    a- Download SpaceMono nerd font
        curl -fLo "SpaceMonoNerdFont-Regular.ttf" \
        https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SpaceMono/Regular/SpaceMonoNerdFont-Regular.ttf

    b- Create a dir for the font to be installed from
        mkdir -p ~/.fonts
    
    c- Move the Downloaded font to that dir 
        mv SpaceMonoNerdFont-Regular.ttf ~/.fonts/
        
    d- Finally install the font
        fc-cache -f -v
        
## Step 4. Configure the terminal
    a- change the default font in the terminal prefences to the new font (SpaceMono Nerd Font) # if you don't see it try to open another terminal and chack if not repeat the proccess
    b- Copy paste my custom toml file to this path ~/.config/starship.toml
    
#### And voila you're now all set for greatness
