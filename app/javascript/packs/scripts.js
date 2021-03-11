svg4everybody();

jQuery(document).ready( function() {

	/* Category detector. */
		// Without "main".
		var availableCategories = [ "asian", "bbq", "beer", "breakfast", "cocktail", "coffee", "dessert", "drink", "fruit", "junk", "meat", "pasta", "pizza", "salad", "seafood", "snack", "soup", "tea", "vegetarian", "vegan" ];

		function categoryDetector() {
			jQuery('.index .posts .post').each( function() {
				var postURL = jQuery(this).find('.post-title a').attr('href');
				var tags = jQuery(this).find('.category a');
				var tagsText = tags.text().toLowerCase().replace(/\s/g, "");
				var tagIndex = jQuery.inArray(tagsText, availableCategories);
				if (jQuery.inArray(tagsText, availableCategories) !== -1) {
					jQuery('<a href="' + postURL + '" class="category-' + tagsText + '"><svg width="60" height="60"><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="{{ site.baseurl | prepend: site.url }}/assets/svg/food-categories.svg#' + availableCategories[tagIndex] + '"></use></svg></a>').appendTo(jQuery(this).find('.post-image'));
				}
				else {
					jQuery('<a href="' + postURL + '" class="category-main"><svg width="60" height="60"><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="{{ site.baseurl | prepend: site.url }}/assets/svg/food-categories.svg#main"></use></svg></a>').appendTo(jQuery(this).find('.post-image'));
				}
			});
		}

		categoryDetector();
	/**/

	/* Make first unordered list in the post - recipe list. */
		var getFirstUnList = jQuery('.post.single .post-content').find('ul:first-of-type:first');
		getFirstUnList.addClass('recipe-ingredients').attr('id', 'recipe-ingredients');
		getFirstUnList.find('li').on('click', function() {
            jQuery(this).toggleClass('selected');
		});
	/**/
});
