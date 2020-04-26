function success = initializeVlfeat()

vlfeat_setup_cache_file_path = fullfile('cache', 'vlfeat_install_path.txt');

% Try to get the vl_setup.m script path from our cache
vlfeat_setup_script_path = tryGetVlfeatSetupPath(vlfeat_setup_cache_file_path);

% Check that the cached path is valid. If not, ask the user for VLFeat
% installation.
if ~isfile(vlfeat_setup_script_path)
    
    % Ask the user for the path
    if ~askUserForVlfeatInstallationAndCacheAnswer(vlfeat_setup_cache_file_path)
        success = false;
        return;
    end
    
    % Try getting it from the cache again. This time it should succeed.
    vlfeat_setup_script_path = tryGetVlfeatSetupPath(vlfeat_setup_cache_file_path);
    assert(isfile(vlfeat_setup_script_path));
end

% Run setup
run(vlfeat_setup_script_path);

success = true;

end


function success = askUserForVlfeatInstallationAndCacheAnswer(vlfeat_setup_cache_file_path)
    
    % First time user is running. Figure out where the user installed VLFeat
    fprintf('Please select where VLFeat was installed\n');
    vlfeat_install_dir = uigetdir();
    
    % Search for vl_setup.m in the provided path
    found_listings = dir(fullfile(vlfeat_install_dir, '**/vl_setup.m'));
    
    if size(found_listings, 1) == 0
        fprintf(2, 'Unable to find vl_setup.m in provided directory: %s\n', vlfeat_install_dir);
        success = false;
        return;
    end
    
    % Just get the first listing (should really only be 1 anyway)
    vlfeat_setup_listing = found_listings(1);
    vlfeat_setup_path = fullfile(vlfeat_setup_listing.folder, vlfeat_setup_listing.name);
    
    % Cache the vl_setup.m path to disk
    cache_dir = fileparts(vlfeat_setup_cache_file_path);
    if ~isdir(cache_dir)
        mkdir(cache_dir);
    end
    vlfeat_setup_cache_file = fopen(vlfeat_setup_cache_file_path, 'w');
    fprintf(vlfeat_setup_cache_file, '%s', vlfeat_setup_path);
    fclose(vlfeat_setup_cache_file);

    success = true;
end


function path = tryGetVlfeatSetupPath(vlfeat_setup_cache_file_path)
    path = '';
    
    % No cached file
    if ~isfile(vlfeat_setup_cache_file_path)
        return;
    end
    
    vlfeat_setup_cache_file = fopen(vlfeat_setup_cache_file_path, 'r');
    vlfeat_setup_path = fgets(vlfeat_setup_cache_file);
    fclose(vlfeat_setup_cache_file);
    
    if ~isfile(vlfeat_setup_path)
        % Cached path was invalid
        return;
    end

    % If we get here, then success. We found a valid path to vl_setup.m
    path = vlfeat_setup_path;
end