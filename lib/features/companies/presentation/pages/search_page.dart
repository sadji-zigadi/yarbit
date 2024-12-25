import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:client/core/shared/controller/search/search_cubit.dart';
import 'package:client/core/shared/entities/company_entity.dart';
import 'package:client/core/shared/widgets/custom_app_bar.dart';
import 'package:client/features/auth/presentation/widgets/loading_widget.dart';
import 'package:client/features/home/domain/entities/category_entity.dart';
import 'package:client/features/companies/presentation/controllers/categories/categories_cubit.dart';
import 'package:client/features/companies/presentation/widgets/categories_widget.dart';
import '../controllers/companies/companies_cubit.dart';
import '../widgets/grid_view_companies.dart';
import '../../../home/presentation/widgets/circle_image_widget.dart';
import '../../../../core/utils/language_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../injection_container.dart' as ic;
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/text_field_type.dart';
import '../../../../core/utils/wilaya_communes.dart';
import '../../../auth/presentation/widgets/text_form_field_custom.dart';

final searchPageKey = GlobalKey<SearchPageState>();

@RoutePage()
class SearchPage extends StatefulWidget implements AutoRouteWrapper {
  SearchPage({required final Key key}) : super(key: searchPageKey);

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<SearchCubit>(
      create: (context) => ic.sl<SearchCubit>(),
      child: this,
    );
  }

  @override
  State<SearchPage> createState() => SearchPageState();

  static SearchPageState? of(BuildContext context) {
    return context.findAncestorStateOfType<SearchPageState>();
  }
}

class SearchPageState extends State<SearchPage> {
  final GlobalKey<FormState> formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  final TextEditingController searchCtrl = TextEditingController();
  final AutoSizeGroup group = AutoSizeGroup();

  List<CompanyEntity> companies = [];

  String? selWilaya;
  String? selCommune;
  bool withAddress = false;
  CategoryEntity? selectedCategory;

  void filterCompanies({CategoryEntity? category}) {
    // if (category != null) {
    //   selectedCategory = category;
    //   context.read<CategoriesCubit>().selectCategory(selectedCategory);
    // }
    // context.read<SearchCubit>().filterCompanies(
    //       companies: companies,
    //       query: searchQuery,
    //       category: selectedCategory,
    //       wilaya: selWilaya,
    //       commune: selCommune,
    //     );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: trans(context).search,
        customActions: const [CircleImage()],
      ),
      body: BlocBuilder<CompaniesCubit, CompaniesState>(
        builder: (context, state) {
          if (state is CompaniesSuccess) {
            companies = state.companies;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  right: 15,
                  left: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildMenu(withAddress),
                    const SizedBox(height: 28),
                    Text(
                      trans(context).allCompanies,
                      style: AppTextStyles.custom0,
                    ),
                    const SizedBox(height: 12),
                    _buildCategories(),
                    const SizedBox(height: 24),
                    _buildCompanies(companies),
                  ],
                ),
              ),
            );
          } else if (state is CompaniesLoading) {
            return Padding(
              padding: const EdgeInsets.only(
                top: 20,
                right: 15,
                left: 15,
              ),
              child: SizedBox(
                height: double.maxFinite,
                width: double.maxFinite,
                child: Column(
                  children: <Widget>[
                    _buildMenu(withAddress),
                    const SizedBox(height: 28),
                    _buildCategories(),
                    const SizedBox(height: 16),
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
          } else {
            return Padding(
              padding: const EdgeInsets.only(
                top: 20,
                right: 15,
                left: 15,
              ),
              child: SizedBox(
                height: double.maxFinite,
                width: double.maxFinite,
                child: _buildMenu(withAddress),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildMenu(bool withAddress) {
    if (withAddress) {
      return Column(
        children: [
          _buildTextField(),
          const SizedBox(height: 15),
          _buildAddress(),
        ],
      );
    } else {
      return _buildTextField();
    }
  }

  Widget _buildTextField() {
    return Form(
      key: formKey1,
      child: TextFormFieldCustom(
        onTap: () {
          setState(() {
            withAddress = !withAddress;
          });
        },
        onChanged: (value) {
          context.read<SearchCubit>().updateSearchQuery(value);
          log(context.read<SearchCubit>().searchQuery);
          context.read<SearchCubit>().filterCompanies(companies: companies);
        },
        controller: searchCtrl,
        hintText: trans(context).lookingForWorker,
        type: TextFieldType.text,
        suffixIcon: Iconsax.setting4,
      ),
    );
  }

  Widget _buildAddress() {
    return Form(
      key: formKey2,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trans(context).wilaya,
                  style: AppTextStyles.bodySmall
                      .copyWith(color: AppColors.accentBlack),
                ),
                const SizedBox(height: 5),
                DropdownButtonFormField(
                  items: wilayasCommunes.keys
                      .map(
                        (wilaya) => DropdownMenuItem<String>(
                          value: wilaya,
                          child: Text(
                            wilaya,
                            style: AppTextStyles.body
                                .copyWith(color: AppColors.accentBlack),
                          ),
                        ),
                      )
                      .toList(),
                  value: selWilaya,
                  isExpanded: true,
                  onChanged: (value) {
                    if (value != selWilaya) {
                      selCommune = null;
                    }

                    setState(() {
                      selWilaya = value;
                    });

                    context.read<SearchCubit>().updateWilaya(selWilaya!);
                    context
                        .read<SearchCubit>()
                        .filterCompanies(companies: companies);
                  },
                  validator: (value) {
                    if (value == null) {
                      return trans(context).pleaseSelectAWilaya;
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trans(context).municipality,
                  style: AppTextStyles.bodySmall
                      .copyWith(color: AppColors.accentBlack),
                ),
                const SizedBox(height: 5),
                DropdownButtonFormField(
                  items: wilayasCommunes[selWilaya]
                      ?.map(
                        (commune) => DropdownMenuItem(
                          value: commune,
                          child: Text(
                            commune,
                            style: AppTextStyles.body
                                .copyWith(color: AppColors.accentBlack),
                          ),
                        ),
                      )
                      .toList(),
                  value: selCommune,
                  isExpanded: true,
                  onChanged: (value) {
                    setState(() {
                      selCommune = value;
                    });

                    context.read<SearchCubit>().updateCommune(selCommune!);
                    context
                        .read<SearchCubit>()
                        .filterCompanies(companies: companies);
                  },
                  validator: (value) {
                    if (value == null) {
                      return trans(context).pleaseSelectACommune;
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesLoaded) {
          return CategoriesWidget(
            selectedCategories: state.visibleCategories,
            categories: state.categories,
            companies: companies,
          );
        } else if (state is CategoriesLoading) {
          return const SizedBox(
            height: 100,
            child: LoadingWidget(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.main,
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _buildCompanies(List<CompanyEntity> companies) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchSuccess) {
          if (state.items.isEmpty) {
            return Center(
              child: Text(
                trans(context).noCompaniesFound,
                style: AppTextStyles.body,
              ),
            );
          }
          return GridViewCompanies(
              companies: state.items as List<CompanyEntity>);
        } else if (state is SearchReset) {
          return GridViewCompanies(
              companies: state.items as List<CompanyEntity>);
        } else {
          return GridViewCompanies(companies: companies);
        }
      },
    );
  }
}
