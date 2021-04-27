#include <iostream>
#include <fstream>

// DataSketches/
#include <DataSketches/hll.hpp>

//simplified file operations and no error handling for clarity
int main(int argc, char **argv)
{
    const int lg_k = 11;
    const auto type = datasketches::HLL_4; // this is the default, but explicit here for illustration

    // this section generates two sketches with some overlap and serializes them into files
    {
        // 100000 distinct keys
        datasketches::hll_sketch sketch1(lg_k, type); // type is optional, defaults to HLL_4
        for (int key = 0; key < 100000; key++)
            sketch1.update(key);
        std::ofstream os1("hll_sketch1.bin");
        sketch1.serialize_compact(os1);

        // 100000 distinct keys
        datasketches::hll_sketch sketch2(lg_k, type); // type is optional, defaults to HLL_4
        for (int key = 50000; key < 150000; key++)
            sketch2.update(key);
        std::ofstream os2("hll_sketch2.bin");
        sketch2.serialize_compact(os2);
    }

    // this section deserializes the sketches, produces union and prints the result
    {
        std::ifstream is1("hll_sketch1.bin");
        datasketches::hll_sketch sketch1 = datasketches::hll_sketch::deserialize(is1);

        std::ifstream is2("hll_sketch2.bin");
        datasketches::hll_sketch sketch2 = datasketches::hll_sketch::deserialize(is2);

        datasketches::hll_union u(lg_k);
        u.update(sketch1);
        u.update(sketch2);
        datasketches::hll_sketch sketch = u.get_result(type); // type is optional, defaults to HLL_4

        // debug summary of the union result sketch
        sketch.to_string(std::cout);

        std::cout << "Distinct count estimate: " << sketch.get_estimate() << std::endl;
        std::cout << "Distinct count lower bound 95% confidence: " << sketch.get_lower_bound(2) << std::endl;
        std::cout << "Distinct count upper bound 95% confidence: " << sketch.get_upper_bound(2) << std::endl;
    }

    return 0;
}