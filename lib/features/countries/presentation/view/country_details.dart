// ignore_for_file: unnecessary_null_comparison

import 'package:carousel_slider/carousel_slider.dart';
import 'package:explore/core/util/size_config.dart';
import 'package:explore/features/countries/domain/models/country_model.dart';
import 'package:flutter/material.dart';

class CountryDetails extends StatelessWidget {
  final Country country;
  const CountryDetails({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    final CarouselController controller = CarouselController();
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        title: Text(
          country.name!.common.toString(),
          style: Theme.of(context).textTheme.headline6,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: country.coatOfArms == null
          ? const Center(
              child: Text('Unable to fetch Details'),
            )
          : Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.fromWidth(context, 5.6),
                vertical: SizeConfig.fromHeight(context, 2.8),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CarouselSlider(
                          carouselController: controller,
                          items: [
                            Image.network(
                              country.flags!.png.toString(),
                              fit: BoxFit.cover,
                            ),
                            country.coatOfArms == null
                                ? const SizedBox()
                                : Image.network(
                                    country.coatOfArms!.png.toString()),
                            // Image.network(country.flags!.png!)
                          ],
                          options: CarouselOptions(
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              padEnds: false,
                              height: SizeConfig.fromHeight(context, 21.6),
                              viewportFraction: 1),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: SizeConfig.fromHeight(context, 8)),
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: controller.previousPage,
                                  icon: const Icon(Icons.arrow_back_ios)),
                              const Spacer(),
                              IconButton(
                                  onPressed: controller.nextPage,
                                  icon: const Icon(Icons.arrow_forward_ios))
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    detailRow(context, 'Official Name', country.name!.official),
                    detailRow(context, 'Official Language',
                        country.languages!.values.first),
                    detailRow(
                        context,
                        'Capital',
                        country.capital == null
                            ? const SizedBox()
                            : country.capital!.toString().substring(
                                1, country.capital!.toString().length - 1)),
                    detailRow(context, 'Region', country.region),
                    detailRow(
                      context,
                      'Sub Region',
                      country.subregion,
                    ),
                    detailRow(
                      context,
                      'UN Member',
                      country.unMember == true ? 'Yes' : 'No',
                    ),
                    SizedBox(
                      height: SizeConfig.fromHeight(context, 3),
                    ),
                    detailRow(context, 'Population', country.population),
                    detailRow(context, 'Area', '${country.area} km2'),
                    detailRow(context, 'Currency',
                        country.currencies!.values.first['name']),
                    detailRow(
                        context,
                        'Time zone',
                        country.timezones.toString().substring(
                            1, country.timezones.toString().length - 1)),
                    SizedBox(
                      height: SizeConfig.fromHeight(context, 3),
                    ),
                    detailRow(
                        context,
                        'Driving Side',
                        country.car!.side!.replaceFirst(country.car!.side![0],
                            country.car!.side![0].toUpperCase())),
                    detailRow(context, 'Latitude', country.latlng![0]),
                    detailRow(context, 'Longitude', country.latlng![1])
                  ],
                ),
              ),
            ),
    );
  }
}

Widget detailRow(context, title, detail) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: SizeConfig.fromHeight(context, 1)),
    child: Row(
      children: [
        Text(
          title + ':',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: SizeConfig.fontSize(context, 4)),
        ),
        SizedBox(
          width: SizeConfig.fromWidth(context, 5),
        ),
        Expanded(child: Text(detail.toString()))
      ],
    ),
  );
}