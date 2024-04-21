/* HTTP Cloud Function.
 *
 * @param {Object} req Cloud Function request context.
 * @param {Object} res Cloud Function response context.
 */

const { SecretManagerServiceClient } = require("@google-cloud/secret-manager");
const client = new SecretManagerServiceClient();

exports.helloGET = async (req, res) => {
  const secretName =
    "projects/fivetran-function-419419/secrets/my-secret/versions/latest";

  try {
    const [version] = await client.accessSecretVersion({
      name: secretName,
    });

    // Extract the payload as a string.
    const payload = version.payload.data.toString();

    res
      .status(200)
      .send(`Hello from Cloud Functions! Secret content: ${payload}`);
  } catch (err) {
    console.error("Error accessing secret:", err);
    res.status(500).send("Error accessing secret");
  }
};
