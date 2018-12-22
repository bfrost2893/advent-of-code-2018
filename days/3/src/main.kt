class Claim(val claim: String) {
  var claimId: String
  var colStart: Int
  var rowStart: Int
  var colEnd: Int
  var rowEnd: Int

  init {
    val splitClaim = claim.split(" ")
    val coordSplit = splitClaim[2].split(",")
    val sizeSplit = splitClaim[3].split("x")
    claimId = splitClaim[0].removePrefix("#")
    colStart = coordSplit[0].toInt()
    rowStart = coordSplit[1].removeSuffix(":").toInt()
    colEnd = colStart + sizeSplit[0].toInt()
    rowEnd = rowStart + sizeSplit[1].toInt()
  }

  override fun toString(): String {
    return "#$claimId @ $colStart,$rowStart $colEnd,$rowEnd"
  }
}

// keep track of all sq in of fabric
// store array of sq in, where each element holds a pointer to the claim
// array will be n x m length long, where where row * numCols + col gets your the sq in at (row, col)
fun buildFabricSheet(claimsList: List<Claim>): HashMap<String, MutableList<Claim>> {
  val fabricSheet = HashMap<String, MutableList<Claim>>()
  // var sharedClaims = 0
  for (claim in claimsList) {
    for (col in claim.colStart until claim.colEnd) {
      for (row in claim.rowStart until claim.rowEnd) {
        val sheetKey = "$col,$row"
        if (!fabricSheet.containsKey(sheetKey)) {
          fabricSheet[sheetKey] = mutableListOf<Claim>()
        }

        fabricSheet[sheetKey]!!.add(claim)

        // Method for finding shared claims while building fabric sheet
        /*
        if (fabricSheet[sheetKey]!!.count() == 2) {
          sharedClaims++
        }
        */
      }
    }
  }

  return fabricSheet
}

fun main(args: Array<String>) {
  val claimsList = System.`in`.bufferedReader().readLines().map { Claim(it) }
  val fabricSheet = buildFabricSheet(claimsList)

  // Part 1
  // Find number of shared claims (after building fabric sheet)
  // Method for finding while building sheet is above in comments
  var sharedClaims = 0
  for ((_, claimsInSquare) in fabricSheet) {
    if (claimsInSquare.count() > 1) {
      sharedClaims++
    }
  }

  // Part 2
  // Find the claim with no overlap among other claims
  var claimWithNoOverlap: Claim? = null
  for (claim in claimsList) {
    var hasOverlap = false
    for (col in claim.colStart until claim.colEnd) {
      for (row in claim.rowStart until claim.rowEnd) {
        val sheetKey = "$col,$row"

        if (fabricSheet[sheetKey]!!.count() > 1) {
          hasOverlap = true
        }
      }
    }

    if (!hasOverlap) {
      claimWithNoOverlap = claim
    }
  }

  println("Square inches of fabric with two or more claims: $sharedClaims")
  println("Claim #${claimWithNoOverlap?.claimId} has no overlap with other claims")
}
