addCommas = function(input){
  // If the regex doesn't match, `replace` returns the string unmodified
  return (input.toString()).replace(
    // Each parentheses group (or 'capture') in this regex becomes an argument 
    // to the function; in this case, every argument after 'match'
    /^([-+]?)(0?)(\d+)(.?)(\d+)$/g, function(match, sign, zeros, before, decimal, after) {

      // Less obtrusive than adding 'reverse' method on all strings
      var reverseString = function(string) { return string.split('').reverse().join(''); };

      // Insert commas every three characters from the right
      var insertCommas  = function(string) { 

        // Reverse, because it's easier to do things from the left
        var reversed           = reverseString(string);

        // Add commas every three characters
        var reversedWithCommas = reversed.match(/.{1,3}/g).join(',');

        // Reverse again (back to normal)
        return reverseString(reversedWithCommas);
      };

      // If there was no decimal, the last capture grabs the final digit, so
      // we have to put it back together with the 'before' substring
      return sign + (decimal ? insertCommas(before) + decimal + after : insertCommas(before + after));
    }
  );
};

$.fn.addCommas = function() {
  $(this).each(function(){
    $(this).text(addCommas($(this).text()));
  });
};