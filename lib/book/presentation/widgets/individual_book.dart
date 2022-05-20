part of '../book_search_page.dart';

class _IndividualBook extends StatelessWidget {
  const _IndividualBook({
    Key? key,
    required this.book,
  }) : super(key: key);
  final Book book;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 10,
                      ),
                      child: Text(
                        'Details',
                        style: StyleConstants.dialogTitleStyle,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsetsDirectional.all(6),
                        decoration: const BoxDecoration(
                          color: ColorConstants.primaryColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                          ),
                        ),
                        child: const Icon(
                          Icons.close,
                          color: ColorConstants.whiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 44),
                  child: Placeholder(
                    fallbackHeight: 200,
                    fallbackWidth: 100,
                    color: ColorConstants.primaryColor,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    book.bookName.getOrCrash(),
                    textAlign: TextAlign.center,
                    style: StyleConstants.bookTitleStyle,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Text(
                        book.author.getOrElse('Unknown'),
                      ),
                      const Spacer(),
                      Text(
                        book.pageCount == null ? 'Unknown pages' : '${book.pageCount!.getOrCrash().toString()} pages',
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Text(
                        'Year ${book.releasedAt.getOrCrash()}',
                      ),
                      const Spacer(),
                      Text(
                        'Edition # ${book.edition.getOrCrash()}',
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: ColorConstants.bookBackgroundColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF00192C).withOpacity(.2),
              offset: const Offset(0, 4),
              blurRadius: 4,
              spreadRadius: 0,
            )
          ],
        ),
        padding: const EdgeInsets.all(8),
        child: LayoutBuilder(builder: (context, constr) {
          return Column(
            children: [
              Placeholder(
                fallbackHeight: constr.maxHeight * .5,
                fallbackWidth: constr.maxWidth * .8,
                color: ColorConstants.primaryColorAccent,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                book.bookName.getOrCrash(),
                style: StyleConstants.bookTitleStyle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                book.author.getOrElse('Unknown'),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Year ${book.releasedAt.getOrCrash()}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          );
        }),
      ),
    );
  }
}
