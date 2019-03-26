<?php
///////////////////////////////////////////////////////////////////////////////////
//                                                                               //
// This is using a sample local WordPress Install and is not production safe     //
// It uses the  REST and Basic Auth plugins                                      //
//                                                                               //
///////////////////////////////////////////////////////////////////////////////////
// setup user name and password
$username = 'admin';
$password = 'ctdI scpG rORi zjB7 foZG cvCp';
$post_count = 1000;
$comment_count = 1000;
// the standard end point for posts in an initialised Curl
$content = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent volutpat mi ac dui euismod egestas. Maecenas euismod turpis eu mauris efficitur facilisis. Phasellus congue purus et neque efficitur vestibulum. Aliquam consectetur odio at nulla imperdiet, vel congue diam tempus. Donec vestibulum libero quis velit vehicula fermentum. Duis ultrices, orci vitae fermentum malesuada, enim erat bibendum lacus, ac congue mauris nisl non velit. Phasellus a ex sit amet lorem tincidunt dictum id quis quam. Praesent in malesuada nibh, et fringilla urna.

Vivamus non arcu metus. Donec egestas dolor sapien, non dapibus ligula aliquet ac. Vivamus at vehicula justo, a maximus purus. Ut porttitor varius risus a tincidunt. Curabitur mattis enim vitae lectus semper auctor. Ut pretium bibendum semper. Curabitur porttitor, lorem sodales tincidunt rutrum, urna nibh lacinia lacus, nec consectetur lectus dolor sit amet nisl. Vivamus viverra, magna vel mollis molestie, massa dolor facilisis ligula, commodo lobortis diam orci ac arcu. Nulla nibh tortor, faucibus sit amet laoreet quis, imperdiet a lectus. Vivamus egestas dapibus rhoncus. Nulla dictum nulla ac felis luctus, a congue massa condimentum. Nulla nisl nisl, tempor non sodales et, mattis sit amet nisl.

Pellentesque imperdiet, elit in auctor semper, dui odio fringilla nisi, sit amet interdum diam dolor quis metus. Quisque euismod sit amet dolor vitae placerat. Mauris in ligula placerat, aliquam purus ut, venenatis enim. Praesent pellentesque, orci eu auctor pellentesque, nunc nibh venenatis lorem, congue condimentum odio dolor non orci. Nunc feugiat pharetra turpis eget elementum. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nulla iaculis erat luctus consequat rutrum. Praesent ultricies a risus eget consequat. Integer viverra massa accumsan efficitur sodales. Proin nibh diam, semper in ligula quis, molestie faucibus dui. Mauris dignissim dolor massa, vulputate tristique odio vehicula vitae. Vestibulum et lorem imperdiet, congue risus a, efficitur justo. Phasellus sit amet pellentesque lorem. Sed mollis efficitur egestas. Pellentesque feugiat cursus leo, vitae sodales velit. Proin luctus tellus eget augue imperdiet, quis congue leo rutrum.

Vestibulum at aliquet justo, eget posuere turpis. Ut sodales nisl arcu, quis venenatis diam viverra vitae. Sed lobortis maximus mollis. In nec suscipit eros, vitae tristique dolor. Praesent a posuere nibh. Nullam ultrices mollis turpis, ut facilisis velit. Mauris ac tellus lacus. Duis rhoncus leo felis, ac commodo odio lobortis et. Donec volutpat elit a nibh pretium condimentum. Fusce porta consequat enim ac semper. Nullam suscipit lacus leo. Aenean fermentum sem urna, ut pretium leo interdum ac. Morbi aliquet, lacus quis lacinia faucibus, nibh odio euismod eros, ac posuere diam augue vel felis. Phasellus ac lectus eleifend leo finibus placerat.

Aliquam erat volutpat. Aliquam egestas, arcu vel interdum tristique, odio quam feugiat dolor, quis rhoncus mauris eros nec nisl. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla diam turpis, fermentum non tellus nec, efficitur malesuada orci. Fusce imperdiet vestibulum neque sit amet auctor. Sed mi augue, dapibus eu ligula ac, faucibus ullamcorper erat. Cras laoreet ante ligula, in pellentesque metus condimentum id. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent volutpat mi ac dui euismod egestas. Maecenas euismod turpis eu mauris efficitur facilisis. Phasellus congue purus et neque efficitur vestibulum. Aliquam consectetur odio at nulla imperdiet, vel congue diam tempus. Donec vestibulum libero quis velit vehicula fermentum. Duis ultrices, orci vitae fermentum malesuada, enim erat bibendum lacus, ac congue mauris nisl non velit. Phasellus a ex sit amet lorem tincidunt dictum id quis quam. Praesent in malesuada nibh, et fringilla urna.

Vivamus non arcu metus. Donec egestas dolor sapien, non dapibus ligula aliquet ac. Vivamus at vehicula justo, a maximus purus. Ut porttitor varius risus a tincidunt. Curabitur mattis enim vitae lectus semper auctor. Ut pretium bibendum semper. Curabitur porttitor, lorem sodales tincidunt rutrum, urna nibh lacinia lacus, nec consectetur lectus dolor sit amet nisl. Vivamus viverra, magna vel mollis molestie, massa dolor facilisis ligula, commodo lobortis diam orci ac arcu. Nulla nibh tortor, faucibus sit amet laoreet quis, imperdiet a lectus. Vivamus egestas dapibus rhoncus. Nulla dictum nulla ac felis luctus, a congue massa condimentum. Nulla nisl nisl, tempor non sodales et, mattis sit amet nisl.

Pellentesque imperdiet, elit in auctor semper, dui odio fringilla nisi, sit amet interdum diam dolor quis metus. Quisque euismod sit amet dolor vitae placerat. Mauris in ligula placerat, aliquam purus ut, venenatis enim. Praesent pellentesque, orci eu auctor pellentesque, nunc nibh venenatis lorem, congue condimentum odio dolor non orci. Nunc feugiat pharetra turpis eget elementum. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nulla iaculis erat luctus consequat rutrum. Praesent ultricies a risus eget consequat. Integer viverra massa accumsan efficitur sodales. Proin nibh diam, semper in ligula quis, molestie faucibus dui. Mauris dignissim dolor massa, vulputate tristique odio vehicula vitae. Vestibulum et lorem imperdiet, congue risus a, efficitur justo. Phasellus sit amet pellentesque lorem. Sed mollis efficitur egestas. Pellentesque feugiat cursus leo, vitae sodales velit. Proin luctus tellus eget augue imperdiet, quis congue leo rutrum.

Vestibulum at aliquet justo, eget posuere turpis. Ut sodales nisl arcu, quis venenatis diam viverra vitae. Sed lobortis maximus mollis. In nec suscipit eros, vitae tristique dolor. Praesent a posuere nibh. Nullam ultrices mollis turpis, ut facilisis velit. Mauris ac tellus lacus. Duis rhoncus leo felis, ac commodo odio lobortis et. Donec volutpat elit a nibh pretium condimentum. Fusce porta consequat enim ac semper. Nullam suscipit lacus leo. Aenean fermentum sem urna, ut pretium leo interdum ac. Morbi aliquet, lacus quis lacinia faucibus, nibh odio euismod eros, ac posuere diam augue vel felis. Phasellus ac lectus eleifend leo finibus placerat.

Aliquam erat volutpat. Aliquam egestas, arcu vel interdum tristique, odio quam feugiat dolor, quis rhoncus mauris eros nec nisl. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla diam turpis, fermentum non tellus nec, efficitur malesuada orci. Fusce imperdiet vestibulum neque sit amet auctor. Sed mi augue, dapibus eu ligula ac, faucibus ullamcorper erat. Cras laoreet ante ligula, in pellentesque metus condimentum id. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent volutpat mi ac dui euismod egestas. Maecenas euismod turpis eu mauris efficitur facilisis. Phasellus congue purus et neque efficitur vestibulum. Aliquam consectetur odio at nulla imperdiet, vel congue diam tempus. Donec vestibulum libero quis velit vehicula fermentum. Duis ultrices, orci vitae fermentum malesuada, enim erat bibendum lacus, ac congue mauris nisl non velit. Phasellus a ex sit amet lorem tincidunt dictum id quis quam. Praesent in malesuada nibh, et fringilla urna.

Vivamus non arcu metus. Donec egestas dolor sapien, non dapibus ligula aliquet ac. Vivamus at vehicula justo, a maximus purus. Ut porttitor varius risus a tincidunt. Curabitur mattis enim vitae lectus semper auctor. Ut pretium bibendum semper. Curabitur porttitor, lorem sodales tincidunt rutrum, urna nibh lacinia lacus, nec consectetur lectus dolor sit amet nisl. Vivamus viverra, magna vel mollis molestie, massa dolor facilisis ligula, commodo lobortis diam orci ac arcu. Nulla nibh tortor, faucibus sit amet laoreet quis, imperdiet a lectus. Vivamus egestas dapibus rhoncus. Nulla dictum nulla ac felis luctus, a congue massa condimentum. Nulla nisl nisl, tempor non sodales et, mattis sit amet nisl.

Pellentesque imperdiet, elit in auctor semper, dui odio fringilla nisi, sit amet interdum diam dolor quis metus. Quisque euismod sit amet dolor vitae placerat. Mauris in ligula placerat, aliquam purus ut, venenatis enim. Praesent pellentesque, orci eu auctor pellentesque, nunc nibh venenatis lorem, congue condimentum odio dolor non orci. Nunc feugiat pharetra turpis eget elementum. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nulla iaculis erat luctus consequat rutrum. Praesent ultricies a risus eget consequat. Integer viverra massa accumsan efficitur sodales. Proin nibh diam, semper in ligula quis, molestie faucibus dui. Mauris dignissim dolor massa, vulputate tristique odio vehicula vitae. Vestibulum et lorem imperdiet, congue risus a, efficitur justo. Phasellus sit amet pellentesque lorem. Sed mollis efficitur egestas. Pellentesque feugiat cursus leo, vitae sodales velit. Proin luctus tellus eget augue imperdiet, quis congue leo rutrum.

Vestibulum at aliquet justo, eget posuere turpis. Ut sodales nisl arcu, quis venenatis diam viverra vitae. Sed lobortis maximus mollis. In nec suscipit eros, vitae tristique dolor. Praesent a posuere nibh. Nullam ultrices mollis turpis, ut facilisis velit. Mauris ac tellus lacus. Duis rhoncus leo felis, ac commodo odio lobortis et. Donec volutpat elit a nibh pretium condimentum. Fusce porta consequat enim ac semper. Nullam suscipit lacus leo. Aenean fermentum sem urna, ut pretium leo interdum ac. Morbi aliquet, lacus quis lacinia faucibus, nibh odio euismod eros, ac posuere diam augue vel felis. Phasellus ac lectus eleifend leo finibus placerat.

Aliquam erat volutpat. Aliquam egestas, arcu vel interdum tristique, odio quam feugiat dolor, quis rhoncus mauris eros nec nisl. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla diam turpis, fermentum non tellus nec, efficitur malesuada orci. Fusce imperdiet vestibulum neque sit amet auctor. Sed mi augue, dapibus eu ligula ac, faucibus ullamcorper erat. Cras laoreet ante ligula, in pellentesque metus condimentum id.';
for ($x = 0; $x <= $post_count; $x++) {
    $process = curl_init('http://localhost/index.php/wp-json/wp/v2/posts');
    // create an array of data to use, this is basic - see other examples for more complex inserts
    $data = array('slug' => 'rest_insert '.$x , 'title' => 'REST API insert '.$x , 'content' => $content, 'status' => 'publish' );
    $data_string = json_encode($data);
    // create the options starting with basic authentication
    curl_setopt($process, CURLOPT_USERPWD, $username . ":" . $password);
    curl_setopt($process, CURLOPT_TIMEOUT, 30);
    curl_setopt($process, CURLOPT_POST, 1);
    // make sure we are POSTing
    curl_setopt($process, CURLOPT_CUSTOMREQUEST, "POST");
    // this is the data to insert to create the post
    curl_setopt($process, CURLOPT_POSTFIELDS, $data_string);
    // allow us to use the returned data from the request
    curl_setopt($process, CURLOPT_RETURNTRANSFER, TRUE);
    // we are sending json
    curl_setopt($process, CURLOPT_HTTPHEADER, array(                                                                          
        'Content-Type: application/json',                                                                                
        'Content-Length: ' . strlen($data_string))                                                                       
    );
    // process the request
    $return = curl_exec($process);
    ## Get Post ID
    $result = json_decode($return);
    curl_close($process);

    $post_id = $result->{'id'};
    echo 'Created Post '.$x.' with Post ID '.$post_id."\n";

    // add comments
    for ($y = 0; $y <= $comment_count; $y++) {
        $process2 = curl_init('http://localhost/index.php/wp-json/wp/v2/comments');
        // create an array of data to use, this is basic - see other examples for more complex inserts
        $data = array('content' => 'Added comment '.$y.$content, 'post' => $post_id);
        $data_string = json_encode($data);
        // create the options starting with basic authentication
        curl_setopt($process2, CURLOPT_USERPWD, $username . ":" . $password);
        curl_setopt($process2, CURLOPT_TIMEOUT, 30);
        curl_setopt($process2, CURLOPT_POST, 1);
        // make sure we are POSTing
        curl_setopt($process2, CURLOPT_CUSTOMREQUEST, "POST");
        // this is the data to insert to create the post
        curl_setopt($process2, CURLOPT_POSTFIELDS, $data_string);
        // allow us to use the returned data from the request
        curl_setopt($process2, CURLOPT_RETURNTRANSFER, TRUE);
        // we are sending json
        curl_setopt($process2, CURLOPT_HTTPHEADER, array(                                                                          
            'Content-Type: application/json',                                                                                
            'Content-Length: ' . strlen($data_string))                                                                       
        );
        // process the request
        curl_exec($process2);
        curl_close($process2);
        echo 'Added Comment for '.$y.' for Post ID '.$post_id."\n";
    }

}


// This buit is to show you on the screen what the data looks like returned and then decoded for PHP use
//echo 'Results';
//print_r($return);
//echo 'Decoded';
//$result = json_decode($return, true);
//print_r($result);