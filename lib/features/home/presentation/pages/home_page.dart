import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:client/core/shared/pages/app_page.dart';
import 'package:client/core/shared/widgets/custom_app_bar.dart';
import 'package:client/features/companies/presentation/controllers/categories/categories_cubit.dart';
import 'package:client/features/companies/presentation/controllers/promoted_companies/promoted_companies_cubit.dart';
import 'package:client/features/companies/presentation/pages/search_page.dart';
import 'package:client/features/companies/presentation/widgets/categories_grid_view.dart';
import 'package:client/features/companies/presentation/widgets/companies_list_view.dart';
import '../../../auth/presentation/widgets/loading_widget.dart';
import '../controllers/pictures/pictures_cubit.dart';
import '../widgets/pictures_widget.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/language_functions.dart';
import '../widgets/circle_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../../injection_container.dart' as ic;

@RoutePage()
class HomePage extends StatefulWidget implements AutoRouteWrapper {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ic.sl<PicturesCubit>(),
        ),
        BlocProvider(
          create: (context) => ic.sl<PromotedCompaniesCubit>(),
        ),
      ],
      child: this,
    );
  }
}

class _HomePageState extends State<HomePage> {
  final group = AutoSizeGroup();

  @override
  void initState() {
    super.initState();
    context.read<PicturesCubit>().getPictures(context);
    context.read<PromotedCompaniesCubit>().getPromotedCompanies(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: 'YARBIT',
        customActions: const [CircleImage()],
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<PromotedCompaniesCubit, PromotedCompaniesState>(
      builder: (context, state) {
        if (state is PromotedCompaniesSuccess) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildPictures(),
                  const SizedBox(height: 46),
                  _buildCategories(context),
                  const SizedBox(height: 46),
                  Text(
                    trans(context).popularToday,
                    style: AppTextStyles.custom0,
                  ),
                  const SizedBox(height: 12),
                  CompaniesListView(companies: state.companies),
                ],
              ),
            ),
          );
        } else if (state is PromotedCompaniesLoading) {
          return Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 20,
            ),
            child: SizedBox(
              height: double.maxFinite,
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildPictures(),
                  const SizedBox(height: 16),
                  _buildCategories(context),
                  const SizedBox(height: 16),
                  Text(
                    trans(context).popularToday,
                    style: AppTextStyles.custom0,
                  ),
                  const SizedBox(height: 12),
                  const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.main,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is PromotedCompaniesFailure) {
          return Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 20,
            ),
            child: SizedBox(
              height: double.maxFinite,
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildPictures(),
                  const SizedBox(height: 16),
                  _buildCategories(context),
                  const SizedBox(height: 16),
                  Text(
                    trans(context).popularToday,
                    style: AppTextStyles.custom0,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        state.message,
                        style: AppTextStyles.body,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 20,
            ),
            child: SizedBox(
              height: double.maxFinite,
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildPictures(),
                  const SizedBox(height: 16),
                  _buildCategories(context),
                  const SizedBox(height: 16),
                  Text(
                    trans(context).artisan,
                    style: AppTextStyles.custom1,
                  ),
                  Text(
                    trans(context).recruteYourArtisanNow,
                    style: AppTextStyles.custom2,
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildPictures() {
    return SizedBox(
      width: double.maxFinite,
      height: 21.h,
      child: BlocBuilder<PicturesCubit, PicturesState>(
        builder: (context, state) {
          if (state is PicturesSuccess) {
            return PicturesWidget(
              pictures: state.pictures,
            );
          } else if (state is PicturesFailure) {
            return const Center(
              child: Icon(Icons.error),
            );
          } else if (state is PicturesLoading) {
            return const LoadingWidget(
              foregroundColor: AppColors.main,
              backgroundColor: Colors.white,
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildCategories(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          trans(context).categories,
          style: AppTextStyles.custom0,
        ),
        const SizedBox(height: 12),
        BlocBuilder<CategoriesCubit, CategoriesState>(
          builder: (context, state) {
            if (state is CategoriesLoaded) {
              return CategoriesGridView(
                categories: state.categories,
                onCategorySelected: (category) {
                  tabsRouter.setActiveIndex(1);

                  WidgetsBinding.instance.addPostFrameCallback(
                    (_) {
                      searchPageKey.currentState
                          ?.filterCompanies(category: category);
                    },
                  );
                },
              );
            } else if (state is CategoriesLoading) {
              return const LoadingWidget(
                height: 110,
                foregroundColor: AppColors.main,
                backgroundColor: Colors.white,
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ],
    );
  }
}
