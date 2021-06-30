for (var index = 0; index < category_count; index++) {
    var category = categories[| index];
    ds_list_destroy(category.lines);
}
ds_list_destroy(categories);

ds_list_destroy(results);
