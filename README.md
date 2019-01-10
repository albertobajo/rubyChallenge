# rubyChallenge

Checkout process that fulfills the requirements of [cabify/rubyChallenge](https://github.com/cabify/rubyChallenge)

## Documentation

See `docs/index.html`.

## Code

See `lib/cabify_store/` folder.

### Description

There are three classes grouped under `CabifyStore` module: `Checkout`, `PricingRule` and `PricingLine`.  

#### PricingRule

Stores pricing rule attributes and allow to check the rule logic through `calculate(quantity)` method.

#### PricingLine

Decorator for `PricingRule`, adds a `quantity` attribute and `total` method that uses `calculate(quantity)` from the decorated object to get the final price of the line item.

#### Checkout

Is initialized with a list of `PricingRule` objects, which are decorated with `PricingLine` and assigned to a `Hash` (which keys are the `code` attribute of the `PricingRule`).

After an item is scanned, `PricingLine` is retrieved from the `Hash` and its quantity incremented by one.

When `total` method is called, returns the sum of all of the `PricingLine` objects stored in the `Hash`.

See [documentation](#documentation) for more details.

### Notes

- Because there is not a particular `PricingRule` definition in the challenge statement, I have tried to keep it as simple as possible.
- The decission of modelling `PricingRule` as a `Class` instead a `Hash`, `Struct`, etc., its based on:
	- Less effort to make it a database backed model if needed.
	- It is the most suitable place to implement the price calculation logic.
- `PricingRule` do not need the attribute `discount_bulk`, I could have supposed that if there were a discount_bulk_price the discount should be enabled. But having this attribute allows to enable/disable the discount in a more comfortable way.
- For the checkout process, we need an object for keeping count of the number and type of the items scanned, and the simplest way that has occurred to me is wrapping `PricingRule` with a decorator.
- As there is no instructions about discounts priority, I have set that 2-for-1 discount take precedence over bulk discount. I could have created an scenerio using and applying both, but I find it more prudent doing in that way.
- I thought in moving price calculations to `PricingLine`, but there is no gain and `PricingRule` would have lost funcionality.

## Testing

Code has been covered with acceptance, functional and unit tests. You can run them all with the followign command:

`rake test`

### Acceptance testing

There are acceptance tests written with Cucumber in the `features/` folder.

Run the following command to launch them:

`rake features`

### Unit and functional testing

There are unit and functional tests written with RSpec in the `spec/` folder.

Run the following command to launch them:

`rake spec`

## Prompt

There is a simple script with a prompt to enter item codes. The final price is calculated based on the [rubyChallenge pricing rules](https://github.com/cabify/rubyChallenge#besides-providing-exceptional-transportation-services-cabify-also-runs-a-physical-store-which-sells-only-3-products).

Run the following comand:

`rake prompt`

And introduce some codes to get something like the following result:

```
Items: VOUCHER, TSHIRT, MUG
Total: 32.50€

Items: VOUCHER, TSHIRT, VOUCHER
Total: 25.00€

Items: TSHIRT, TSHIRT, TSHIRT, VOUCHER, TSHIRT
Total: 81.00€

Items: VOUCHER, TSHIRT, VOUCHER, VOUCHER, MUG, TSHIRT, TSHIRT
Total: 74.50€
```
