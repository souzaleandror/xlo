enum OrderBy { DATE, PRICE }

// 0000

const VENDOR_TYPE_PARTICULAR = 1 << 0; // 00001
const VENDOR_TYPE_PROFESSIONAL = 1 << 1; // 0010

// VENDOR_TYPE_PARTICULAR | VENDOR_TYPE_PROFESSIONAL 0011 (Ou logico BitFlag Rotacao de bit)

class Filter {
  Filter({
    this.search,
    this.orderBy = OrderBy.DATE,
    this.minPrice,
    this.maxPrice,
    this.vendorType = VENDOR_TYPE_PROFESSIONAL | VENDOR_TYPE_PARTICULAR,
  });

  String search;
  OrderBy orderBy;
  int minPrice;
  int maxPrice;
  int vendorType;
}
